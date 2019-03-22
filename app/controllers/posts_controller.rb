class PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy edit]
  def index
    @posts = Post.all
    @post = Post.new
  end
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      redirect_to root_path alert: 'error al crear post'
    end
  end 
  def show 
    #inserte aqui  el post a mostrar 
    @comments = @post.comments
    end 
  def edit
  end

  def update
   @post.update(post_params)
   if @post.save
    respond_to :js
   else 
      redirect_to root_path, alert: 'El post no fue actualizado'
   end 
  end
  def destroy
    @post.destroy
    respond_to :js
  end


# metodos de comment
def new_comment
  @post = Post.find(params[:post_id])
  @comment = Comment.new
  respond_to :js
end

def create_comment
  @comment = Comment.new(comment_params)
  @comment.user = current_user
  @comment.post_id = params[:post_id]
  if @comment.save
  respond_to :js
  else 
    redirect_to root_path, alert: 'comentario no se pudo crear'
 end
end


  def search
    parameters = params[:search]
    if parameters.blank?
      @posts = Post.all
      respond_to :js
    elsif parameters.nil?
      @posts = Post.all
      respond_to :js
    else
      @posts = Post.where('title LIKE ?',"%#{parameters}%")
      respond_to :js
    end

end



  private
  def post_params
    params.require(:post).permit(:title, :user_id, :image)
  end 

  def set_post
    @post = Post.find(params[:id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end 
  def comment_params
    params.require(:comment).permit(:content)
  end 
end
