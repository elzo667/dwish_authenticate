class UsersController < ApplicationController
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        # L'utilisateur a été créé avec succès
        redirect_to root_path, notice: "Utilisateur créé avec succès."
      else
        render :new
      end
    end
  
    def login
      # Affiche le formulaire de connexion
    end
  
    def authenticate
      user = User.find_by(email: params[:email])
      if user&.authenticate(params[:password])
        # L'authentification est réussie
        sign_in(user)
        redirect_to root_path, notice: "Vous êtes connecté."
      else
        # L'authentification a échoué
        flash.now[:alert] = "Email ou mot de passe incorrect."
        render :login
      end
    end
  
    def logout
      sign_out(current_user)
      redirect_to root_path, notice: "Vous avez été déconnecté."
    end
  
    private
  
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
  end
  