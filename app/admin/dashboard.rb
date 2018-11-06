ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }
  content title: proc{ I18n.t("active_admin.dashboard") } do
    #div class: "blank_slate_container", id: "dashboard_default_message" do
    #  span class: "blank_slate" do
    #    span I18n.t("active_admin.dashboard_welcome.welcome")
    #    small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #  end
    #end

    columns do
      #column do
      #  panel "Recent Uploaded wallpapers" do
      #    ul do
      #      Wallpaper.last(5).each do |w|
      #        @wallpaper = w
      #        render partial: 'wallpaper_form', wallpaper: @wallpaper
      #      end
      #    end
      #  end
      #end

      column do
        panel "Recent uploaded wallpapers" do
          ul do
            Wallpaper.last(10).reverse.map do |w|
              li link_to(image_tag(w.image.mini_thumb.url), wallpaper_path(w))
            end
          end
        end
      end

      column do
        panel "Recent Created Categories" do
          ul do
            Category.last(5).reverse.map do |c|
              li link_to(c.name, category_path(c))
            end
          end
        end
      end

      column do
        panel "Recent written comments" do
          ul do
            Comment.last(5).reverse.map do |com|
              li link_to(image_tag(com.wallpaper.image.mini_thumb.url), wallpaper_path(com.wallpaper))
              li com.commentable_type
              li com.commentable_id
              li com.text
            end
          end
        end
      end

      column do
        panel "Recent user actions" do
          ul do
            Activity.last(15).reverse.map do |act|
              li act.user
              li act.action
              li link_to(act.url_page)
              li act.created_at
            end
          end
        end
      end

    end
    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
