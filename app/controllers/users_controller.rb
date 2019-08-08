class UsersController < ApplicationController
  include Skip_Before_Action_Concern
  include Admin_User_Concern
  
  def create
    @user=User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Bienvenue dans l'Application Exemple!"
      redirect_to @user
    else
      @titre = "Inscription"
      render 'new'
    end
  end

  def show
    @user=User.find(params[:id])
    @titre = @user.nom
  end

  def new
    @user = User.new
    @titre = "Inscription"
  end

  def edit
    # @user = User.find(params[:id])
    @titre = "Edition du profil"
  end

  def update
  #  @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profil actualisé"
      redirect_to @user
    else
      @titre = "Edition du profil"
      render 'edit'
    end
  end

  def index
    @titre = "Liste des utilisateurs"
    @users = User.paginate(:page => params[:page], :per_page => 20)
#@users = User.where(:user => true).paginate(:page => params[:page]).order('id DESC')
  end

  def destroy 
    User.find(params[:id]).destroy
    flash[:success] = "Utilisateur supprimé."
    redirect_to users_path
  end
end

