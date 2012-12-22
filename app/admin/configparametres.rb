ActiveAdmin.register Configparametre do
      config.sort_order = "producte_id_asc"

  controller do
    def scoped_collection
      Configparametre.includes(:configzones)
    end
  end

      index do
        column :id
        column :nom
        column :producte
        column :configgrup
        column :opcio_defecte do |parametre|
        end
        column :tipus
        column :position
        column :zones do |parametre|
          parametre.configzones.count
        end
        default_actions
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
          f.input :producte
          f.input :configgrup
          f.input :configopcio, :label => "Opcio defecte"
          f.input :tipus
          f.input :position
          f.has_many :configzones do |j|
            j.input :dibuix
            j.input :configurador
            j.input :nom
            j.input :svg
          end
        end

        f.actions
      end
end
