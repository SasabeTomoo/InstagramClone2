class FavoritesController < ApplicationController
  def index
    user = User.find(current_user.id)
    @favorites = user.favorite_feeds
  end
  def create
    favorite = current_user.favorites.create(feed_id: params[:feed_id])
    redirect_to feeds_url, notice: "#{favorite.feed.user.name}さんのブログをお気に入り登録しました"
  end
  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to feeds_url, notice: "#{favorite.feed.user.name}さんのブログをお気に入り解除しました"
  end
end
