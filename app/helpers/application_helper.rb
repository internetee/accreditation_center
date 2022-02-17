module ApplicationHelper
	def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # def toastr_flash
  #   flash.each_with_object([]) do |(type, message), flash_messages|
  #     type = 'success' if type == 'notice'
  #     type = 'error' if type == 'alert'
  #     text = "<script>toastr.#{type}('#{message}', '',
  #             { closeButton: true,
  #             progressBar: true,
  #             onclick: null,
  #             showDuration: 300,
  #             hideDuration: 1000,
  #             timeOut: 5000,
  #             extendedTimeOut: 1000,
  #             showEasing: swing,
  #             hideEasing: linear,
  #             showMethod: fadeIn,
  #             progressBar: true,
  #             hideMethod: fadeOut
  #             })</script>"
  #     flash_messages << text.html_safe if message
  #   end.join("\n").html_safe
  # end

  def toastr_flash
    flash.each_with_object([]) do |(type, message), flash_messages|
      type = 'success' if type == 'notice'
      type = 'error' if type == 'alert'
      text = "<script>toastr.#{type}('#{message}', '', { closeButton: true, progressBar: true })</script>"
      flash_messages << text.html_safe if message
    end.join("\n").html_safe
  end
end
