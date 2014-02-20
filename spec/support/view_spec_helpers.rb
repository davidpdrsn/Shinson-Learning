def with_rendered_page
  render
  page = Capybara.string(rendered)
  yield page
end
