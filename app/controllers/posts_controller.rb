class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_ownership , only: [:edit, :update, :destroy]
  
  def index
     
    if params[:search]
     @posts = Post.search(params[:search]).order('created_at desc')
      if params[:search].include?('#')
      @new_chip = Chip.create(content: params[:search], user_id: current_user.id)
      redirect_to root_path
      end
    else
      if Chip.where(user_id: current_user.id).count ==1
        @posts = Post.search(Chip.find_by_user_id(current_user.id).content).order('created_at desc')
      elsif Chip.where(user_id: current_user.id).count ==2
        @posts = Post.search2(Chip.where(user_id: current_user.id).pluck(:content).first,Chip.where(user_id: current_user.id).pluck(:content).second).order('created_at desc')
      elsif Chip.where(user_id: current_user.id).count ==3
        @posts = Post.search3(Chip.where(user_id: current_user.id).pluck(:content).first,Chip.where(user_id: current_user.id).pluck(:content).second,Chip.where(user_id: current_user.id).pluck(:content).third).order('created_at desc')
      elsif Chip.where(user_id: current_user.id).count ==4
        @posts = Post.search4(Chip.where(user_id: current_user.id).pluck(:content).first,Chip.where(user_id: current_user.id).pluck(:content).second,Chip.where(user_id: current_user.id).pluck(:content).third,Chip.where(user_id: current_user.id).pluck(:content).fourth).order('created_at desc')
      elsif  
        @posts = Post.search5(Chip.where(user_id: current_user.id).pluck(:content).first,Chip.where(user_id: current_user.id).pluck(:content).second,Chip.where(user_id: current_user.id).pluck(:content).third,Chip.where(user_id: current_user.id).pluck(:content).fourth,Chip.where(user_id: current_user.id).pluck(:content).fifth).order('created_at desc')
      else
        @posts = Post.all.order('created_at desc')
      end
    end
    @posts_count = current_user.posts.length
    @chips = current_user.chips
  end
  
  def new
  end 
  
  def create
    new_post = Post.new(user_id: current_user.id, content: params[:content],image: params[:image])
    if new_post.save
      redirect_to root_path
    else
      redirect_to new_post_path
    end
    
  end
  
  def edit
  
  end
  
  def update
    
    @post.content = params[:content]
    
    if @post.save
      redirect_to root_path
    else
      render :eidt
    end
  end
  
  def destroy
    @post.destroy
    redirect_to root_path
  end
  
  def hashtags
    tag=Tag.find_by(name: params[:name])
    @post = tag.posts
  end
  private
  
  def check_ownership
     
    @post = Post.find_by(id: params[:id])
    redirect_to root_path if @post.user_id != current_user.id
  end
end
