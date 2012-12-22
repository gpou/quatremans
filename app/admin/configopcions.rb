ActiveAdmin.register Configopcio do
      index do
        column :id
        column :nom
        column :svg
        column :color do |opcio|
          "<span style='display:inline-block;width:30px;height:30px;border:1px solid grey; background-color:##{opcio.svg};'></span>".html_safe
        end

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
            lf.input :locale, :as => :hidden
          end
        end
        f.inputs "Detalls" do
          f.input :tipus
          f.input :preu
          f.input :svg
        end

        f.actions
      end
end
