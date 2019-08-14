class TweetsController < ApplicationController
  before_action :move_to_index, except: :index

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC").page(params[:page]).per(5)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.create(text: tweet_params[:text], user_id: current_user.id)
    redirect_to tweets_path
  end

  def show
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id
      tweet.update(tweet_params)
      redirect_to root_path
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id
      tweet.destroy
    end
    redirect_to root_path
  end



  private
  def tweet_params
    params.require(:tweet).permit(:text)
  end

  def move_to_index
    redirect to action: :index unless user_signed_in?
  end

end
