class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]

  # GET /feeds
  # GET /feeds.json
  def index
    @feeds = Feed.all
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
    if logged_in?
      @favorite = current_user.favorites.find_by(feed_id: @feed.id)
    else
      redirect_to new_session_path
    end
  end

  # GET /feeds/new
  def new
    if params[:back]
      @feed = Feed.new(feed_params)
    else
      @feed = Feed.new
    end
  end

  # GET /feeds/1/edit
  def edit
  end

  # POST /feeds
  # POST /feeds.json
  def create
    @feed = Feed.new(feed_params)
    @feed.user_id = current_user.id
    if @feed.save
      # FeedMailer.feed_mail(@feed.user).deliver
      redirect_to feeds_path, notice: '記事の投稿ができました'
    else
      render :new_feed_path
    end
  end

  # PATCH/PUT /feeds/1
  # PATCH/PUT /feeds/1.json
  def update
    respond_to do |format|
      if current_user.id == @feed.user_id && @feed.update(feed_params)
        format.html { redirect_to @feed, notice: '記事の編集が完了しました.' }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: '記事の消去ができました' }
      format.json { head :no_content }
    end
  end

  def confirm
    @feed = Feed.new(feed_params)
    @feed.user_id = current_user.id
    render :new if @feed.invalid?
  end
end

private
# Use callbacks to share common setup or constraints between actions.
def set_feed
  @feed = Feed.find(params[:id])
end

# Only allow a list of trusted parameters through.
def feed_params
  params.require(:feed).permit(:image, :image_cache, :title, :content, :user_id)
end
