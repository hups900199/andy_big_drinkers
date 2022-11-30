ActiveAdmin.register Context do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :home, :about, :image

  form do |f|
    f.semantic_errors
    f.inputs
    f.inputs do
      f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image.variant(resize_to_limit: [200, 200]).processed) : ""
    end
    f.actions
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :home, :about]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
