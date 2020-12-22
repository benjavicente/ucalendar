namespace :"gh-pages" do
  task :compile => :environment do
    ENV['GH-PAGES'] = '1'
    JS_FILE_NAME = 'schedule.js'
    CSS_FILE_NAME = 'schedule.css'
    DEPLOY_HOST = 'ucalendar.herokuapp.com'

    sprockets = Sprockets::Environment.new(Rails.root) do |env|
      env.append_path 'app/assets/stylesheets/'
      env.append_path 'app/javascript/packs/'
      env.css_compressor = :sass
      # env.js_compressor = :uglify
    end

    file_writers = []

    # CSS
    css_asset = sprockets.find_asset('application.css')
    file_writers << Proc.new do
      css_asset.write_to(CSS_FILE_NAME)
    end
    # JS
    js_asset = sprockets.find_asset('schedule.js')
    file_writers << Proc.new do
      file_writers << js_asset.write_to(JS_FILE_NAME)
    end
    # HTML
    # app/templates/gh-pages.html.erb
    renderer = ApplicationController.renderer.new http_host: DEPLOY_HOST
    HTML_BODY = renderer.render template: 'schedule/show', layout: false, assigns: { courses: [] }
    html_template = ErbTemplate.new('gh-pages.html')
    file_writers << Proc.new do
      File.write('index.html', html_template.render(binding))
    end

    # Git
    DIR = Dir.mktmpdir
    `git worktree add ../#{DIR} -B gh-pages-temp --force`
    Dir.chdir("../#{DIR}") do
      `git rm . -r`
      `git branch -D gh-pages`
      `git checkout --orphan gh-pages`
      file_writers.each { |e| e&.call }
      `git add -A`
      `git commit -m 'update'`
    end
    `git worktree remove ../#{DIR}`
    `git branch -D gh-pages-temp`
    # Se verifica que todo este bien
    puts 'compiled to branch gh-pages'
    puts `git ls-tree gh-pages`
    puts
    puts `git status`
  end
end
