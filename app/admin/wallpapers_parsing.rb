ActiveAdmin.register_page "Parsing" do
  menu priority: 8, label: proc{ 'Parsing' }
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  action_item :root do
    link_to 'User root', '/'
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
      page.css("img").each do |n|
        picture_link = n.attr('src')
        prefix1 = link[/^https?:/]
        prefix2 = link[/^.*\/\/([^\/]+)/]
        if picture_link.slice(0, 2).eql?('//')
          picture_link = prefix1 + picture_link
        elsif picture_link.slice(0, 1).eql?('/')
          picture_link = prefix2 + picture_link
        end
        picture_list << picture_link
      end
      picture_list
    end

    def save_current_picture(path)
      categories = Category.includes(:subscriptions).all
      wallpaper = Wallpaper.new(title: 'noname', category_id: 1, remote_image_url: path)
      return wallpaper, categories
    end

    panel "Parsing pictures" do
      render partial: 'link_form'
    end

    panel "Parsed pictures" do
      pictures_list = parse_page(params[:link]) if uri?(params[:link])
      pictures_list&.each do |path|
        ul do
          li image_tag(src=Pathname(path).to_s)
          li render partial: 'save_form', locals: { wallpaper: save_current_picture(path)[0],
                                                    categories: save_current_picture(path)[1] }
        end
      end
    end
  end
end


