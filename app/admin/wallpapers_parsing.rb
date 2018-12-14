ActiveAdmin.register_page "Parsing" do
  menu priority: 8, label: proc{ 'Parsing' }
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  action_item :site_main_page do
    link_to "Main_user page", "/"
  end

  content title: proc{ 'Parsing' } do
    def uri?(string)
      uri = URI.parse(string)
      %w( http https ).include?(uri.scheme)
    rescue URI::BadURIError
      false
    rescue URI::InvalidURIError
      false
    end

    def parse_page(link)
      page = Nokogiri::HTML(open(link))
      picture_list = []
      page.css("img").each { |n| picture_list << n.attr('src')}
      picture_list
    end

    def save_current_picture(path)
      Wallpaper.create(title: 'noname', category_id: 1, remote_image_url: path)
    end

    panel "Parsing pictures" do
      render partial: 'link_form'
    end

    panel "Parsed pictures" do
      pictures_list = parse_page(params[:link]) if uri?(params[:link])
      if pictures_list
        ul do
          pictures_list.each do |p|
            li p
            li image_tag(src=Pathname(p).to_s)
            li button_to 'Save', save_current_picture(p)
          end
        end
      end
    end
  end
  # page_action :set_link, method: :post do; end
end


