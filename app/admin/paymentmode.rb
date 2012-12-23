ActiveAdmin.register Paymentmode do
      index do
        column :name
        column :slug
        column :state

        default_actions
      end

      show do |paymentmode|
        attributes_table do
          row :name
          row :slug
          row :state
        end
      end  

      form do |f|
        if f.object.errors.size >= 1
          f.inputs "Errors" do
            f.semantic_errors *f.object.errors.keys
          end
        end
        f.inputs "Detalls" do
          f.input :slug
          f.input :state
        end
        f.globalize_inputs :translations do |lf|
          lf.semantic_errors *lf.object.errors.keys
          lf.object.errors.full_messages.join('|')
          lf.inputs do
            lf.input :name
            lf.input :locale, :as => :hidden
          end
        end

        f.actions
      end
end
