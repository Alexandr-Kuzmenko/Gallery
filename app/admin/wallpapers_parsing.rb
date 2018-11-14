ActiveAdmin.register_page "Parsing" do
  menu priority: 7, label: proc{ 'Parsing' }
  #attr_accessor :link
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
    panel "Parsing pictures" do
      render partial: 'link_form'
    end

    panel "Parsed pictures" do
      pictures_list = parse_page(params[:link]) if uri?(params[:link])
      ul do

        pictures_list.each { |p| li image_tag(src="#{Pathname(p)}") } if pictures_list
      end
    end
  end
  # page_action :set_link, method: :post do; end
end


