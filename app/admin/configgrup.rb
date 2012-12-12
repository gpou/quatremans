ActiveAdmin.register Configgrup do
      index do
        column :id
        column :nom
        column :opcions do |grup|
          table_for grup.configopcions do
            column :nom
          end
        end        

        default_actions
      end

      show do |grup|
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
          f.input :nom
          f.input :tipus
          f.input :coleccio
          f.input :configopcions, :as => :check_boxes, :collection => Configopcio.all
        end

        f.actions
      end
end
