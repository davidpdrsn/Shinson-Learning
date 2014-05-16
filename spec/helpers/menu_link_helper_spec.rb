require "spec_helper"

describe MenuLinkHelper do
  before do
    allow_message_expectations_on_nil
  end

  context "the link path matches the request path" do
    it "add the class" do
      request.stub(:fullpath).and_return("/")

      expect(nav_link_to "Home", "/").to eq '<a class=" current" href="/">Home</a>'
    end

    it "appends the class if the link already has one" do
      request.stub(:fullpath).and_return("/")

      expect(nav_link_to "Home", "/", class: "icon").to eq '<a class="icon current" href="/">Home</a>'
    end
  end

  it "does not add the class if the path doesn't match" do
    request.stub(:fullpath).and_return("/something")

    expect(nav_link_to "Home", "/", class: "icon").to eq '<a class="icon" href="/">Home</a>'
  end
end
