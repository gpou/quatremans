ActiveAdmin.register Producte, {:sort_order => "position"} do
      index do
        column :id
        column :position
        column :nom
        column :fotos do |producte|
          producte.fotos.count
          #producte.fotos.each do |foto|
          #  foto.file.url(:thumb)
          #end
        end
        column :tipus
        column :preu

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
        f.inputs "Detalls" do
          f.input :preu
          f.input :disponible
          f.input :actiu
          f.input :tipus
          f.input :dificultat
          f.input :position
        end
        f.inputs "Col&mdot;ecci&oacute;" do
          f.input :coleccio, :required => true
          f.input :coordenades_coleccio
          f.input :coleccio_path
          f.input :coleccio_mascara_path
        end
        f.inputs "Configuraci&oacute;" do
          f.input :svg
          f.input :svg_davant
          f.input :svg_darrera
        end
        f.inputs "Fotos" do
          f.has_many :fotos do |j|
            if j.object.id
              j.form_buffers.last << "<img src='#{j.object.file.url(:thumb) rescue nil}' style='margin:1em;' />".html_safe
            end
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
