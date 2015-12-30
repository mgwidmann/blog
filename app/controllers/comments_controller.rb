class CommentsController < ApplicationController


  def index
    post = Post.find(params[:post_id])
    @comments = post.comments

    respond_to do |format|
      format.html
      format.xml { render :xml => @comments}
    end
  end

  def show
    post = Post.find(params[:post_id])
    @comment = post.comments.find(params[:id])

    respond_to do |format|
      format.html
      format.xml { render :xml => @comment}
    end
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build

    respond_to do |format|
      format.html
      format.xml { render :xml => @comment }
    end
  end

  def edit
    post = Post.find(params[:post_id])
    @comment = post.comments.find(params[:id])
  end

  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.create(params[:comment])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to([@comment.post, @comment], :notice => 'Comment was successfully created.') }
        format.xml  { render :xml => @comment, :status => :created, :location => [@comment.post, @comment] }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @comment.errors, :status => :unprocessable_entity}
      end
    end
  end

  def update
    post = Post.find(params[:post_id])
    @comment = post.comments.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to([@comment.post, @comment], :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit"}
        format.xml { render :xml => @comment.errors, :status => :unprocessable_entity}
      end
    end

  end

  def destroy
    post = Post.find(params[:post_id])
    @comment = post.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(post_comments_url)}
      format.xml { head :ok}
    end
  end

end
