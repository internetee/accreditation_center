# Rails.application.eager_load!

RailsAdmin.config do |config|
  config.main_app_name = Proc.new { |controller| [ "EIS", "Accreditation Admin Panel - #{controller.params[:action].try(:titleize)}" ] }
  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == CancanCan ==
  config.authorize_with :cancancan

  # config.sidescroll = true
  # config.sidescroll = {num_frozen_columns: 4}

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  # MODELS

  # Answer.class_eval do
  #   def custom_label_method
  #     "Answer: #{self.title_en}"
  #   end
  # end
  #
  # Question.class_eval do
  #   def custom_label_method
  #     "Answer"
  #   end
  # end

  # =========================
  #

  # config.included_models = ["Question", "Category", "Quiz", "TemplateSettingDisplay", "User", "Answer"]
  # config.included_models.sort! { |a, b| b <=> a }

  config.model 'UserAnswer' do
    visible false
  end

  config.model 'UserQuestion' do
    visible false
  end

  config.model 'Result' do
    visible false
  end

  config.model 'PracticeResult' do
    visible false
  end

  config.model 'Practice' do
    visible false
  end

  config.model 'AnswerQuestion' do
    visible false
  end

  config.model 'Question' do
    weight -1

    object_label_method do
      :custom_label_method
    end

    list do
      sidescroll true
      field :title do
        label 'Küsimus Eesti keeles'
      end
      field :title_en do
        label 'Question in English'
      end
      field :category
      field :created_at
      field :updated_at

      include_fields :answers
    end

    edit do
      field :title do
        label 'Küsimus Eesti keeles'
      end
      field :title_en do
        label 'Question in English'
      end
      field :title_en
      field :category
      field :question_type

      include_fields :answers
    end
  end

  config.model 'Quiz' do
    list do
      field :user
      field :result
      field :theory
      field :created_at
    end
  end

  config.model 'Answer' do
    # parent Question
    weight 1

    object_label_method do
      :custom_label_method
    end

    edit do
      field :title_en
      field :title_ee
      field :correct
      field :question
    end

    list do
      field :title_en
      field :title_ee
      field :correct
      field :created_at
      field :updated_at
      field :question do
        searchable [:title]
      end
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    # show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
