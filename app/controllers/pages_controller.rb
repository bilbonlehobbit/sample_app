class PagesController < ApplicationController
  skip_before_action :require_sign_in, only: [:home, :contact, :about, :help]
  skip_before_action :correct_user

  def home
    @titre = "Accueil"
  end

  def contact
    @titre = "Contact"
  end

  def about
    @titre = "A Propos"
  end

  def help
    @titre = "Aide"
  end
end
