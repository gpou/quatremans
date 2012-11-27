ActiveAdmin.register Foto do
      config.sort_order = 'position_asc'

      index :as => :block do |foto|
        ul :for => foto do
          content_tag(:li, "#{foto.id} #{foto.position} #{foto.file_file_name}", :"data-id" => foto.id, :class => "handler")
        end
      end

      collection_action :sort, :method => :post do
        params[:ids].each_with_index do |id, index|
          foto = Foto.find(id)
          foto.update_attribute(:position, index.to_i+1)
        end
        head 200
      end

      show do |foto|
        attributes_table do
          row :nom
        end
      end  

      form :html => { :enctype => "multipart/form-data" } do |f|
        if f.object.errors.size >= 1
          f.inputs "Errors" do
            f.semantic_errors *f.object.errors.keys
          end
        end
        f.inputs "Detalls" do
          f.input :producte, :required => true
          f.input :file, :hint => f.template.image_tag(f.object.file.url(:thumb))
        end
        f.globalize_inputs :translations do |lf|
          lf.semantic_errors *lf.object.errors.keys
          lf.object.errors.full_messages.join('|')
          lf.inputs do
            lf.input :nom

            lf.input :locale, :as => :hidden
          end
        end

        f.actions
      end
end

