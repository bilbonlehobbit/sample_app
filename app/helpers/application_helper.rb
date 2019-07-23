module ApplicationHelper
  
	def logo
	    file_path = image_tag('logo.png', :class => "round")
	    if file_path.nil?
		"LoGo"
		else
		file_path
	end
     end

  # Retourner un titre basé sur la page.
	def titre
	    base_titre = "Simple App du Tutoriel Ruby on Rails"
	     if @titre.nil?
		base_titre
		else
	     "#{base_titre} | #{@titre}"
    end
  end
end
