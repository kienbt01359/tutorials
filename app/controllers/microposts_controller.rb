class MicropostsController < ApplicationController
  before_action :set_micropost, only: [:destroy]
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroyee

  def index
    @microposts = Micropost.all
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    respond_to do |format|
      if @micropost.save
        format.html { redirect_to root_url, notice: 'Micropost was successfully created.' }
        format.json { render action: 'show', status: :created, location: @micropost }
      else
        @feed_items = []
        format.html { render 'static_pages/home' }
      end
    end
  end

  def destroy
    @micropost.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_micropost
      @micropost = Micropost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def micropost_params
      params.require(:micropost).permit(:content, :user_id_id)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
