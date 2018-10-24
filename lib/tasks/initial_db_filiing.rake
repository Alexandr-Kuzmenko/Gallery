namespace :autofilling do
  desc 'Import initial pack of images and categories to db from folder below'
  task init_filling: :environment do
    Dir.chdir("storage/Wallpapers_for_Site")
    Dir.foreach(Dir.pwd) do |d|
      unless d.include? ?.
        @category = Category.new(name: d, user_id: 1)
        @category.save
        Dir.chdir(d)
        Dir.foreach(Dir.pwd) do |w|
          if ['.jpg', '.jpeg', '.png'].include? "#{File.extname(w)}"
            title = File.basename(w, ".*")
            cat_id = Category.find_by_name(d).id
            @wallpaper = Wallpaper.new(title: title, category_id: cat_id)
            @wallpaper.image = Pathname(Dir.pwd << "/#{w}").open
            @wallpaper.save
          end
        end
        Dir.chdir("../")
      end
    end
    Dir.chdir("../../")
  end
end