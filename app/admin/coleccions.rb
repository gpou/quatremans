ActiveAdmin.register Coleccio do
      index do
        column :nom

        default_actions
      end

      show do |coleccio|
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
            lf.input :nom
            lf.input :descripcio

            lf.input :locale, :as => :hidden
          end
        end

        f.actions
      end
end
