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
      env.js_compressor = Uglifier.new(harmony: true)
    end

    file_writers = []

    # CSS
    CSS = sprockets['application.css'].to_s
    # JS
    JS = sprockets['schedule.js'].to_s
    # HTML
    # app/templates/gh-pages.html.erb
    renderer = ApplicationController.renderer.new http_host: DEPLOY_HOST, https: true
    html_template = ErbTemplate.new('gh-pages.html')
    HTML_BODY = renderer.render template: 'schedule/show', layout: false, assigns: { courses: [] }

    # Git
    DIR = Dir.mktmpdir
    `git worktree add ../#{DIR} -B gh-pages-temp --force`
    Dir.chdir("../#{DIR}") do
      `git rm . -r`
      `git branch -D gh-pages`
      `git checkout --orphan gh-pages`
      IO.write('index.html', html_template.render(binding))  # HTML_BODY, SCC y JS son usados
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
    puts
    puts 'Use git push origin gh-pages -f to update the page'
  end
end
