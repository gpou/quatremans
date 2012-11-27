ActiveAdmin.register Producte do
      index do
        column :nom

        default_actions
      end

      show do |producte|
        attributes_table do
          row :nom
        end
      end  

      form do |f|
        if f.object.errors.size >= 1
          f.inputs "Errors" do
            f.semantic_errors *f.object.errors.keys
          end
        end
        f.inputs "Detalls" do
          f.input :coleccio, :required => true
          f.input :preu
        end
        f.globalize_inputs :translations do |lf|
          lf.semantic_errors *lf.object.errors.keys
          lf.object.errors.full_messages.join('|')
          lf.inputs do
            #lf.input :slug
            lf.input :nom
            lf.input :descripcio

            lf.input :locale, :as => :hidden
          end
        end
        f.inputs "Fotos" do
          f.has_many :fotos do |j|
            j.form_buffers.last << "<img src='#{j.object.file.url(:thumb) rescue nil}' style='margin:1em;' />".html_safe
            j.input :position
            j.input :file, :as => :file
            if j.object.id
              j.input :_destroy, :as=>:boolean, :required => false, :label=>'Remove'
            end
            j.form_buffers.last # to avoid bug with nil possibly being returned from the above
          end
        end

        f.actions
      end
end
