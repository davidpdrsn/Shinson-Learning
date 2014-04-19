require_relative "../../lib/zipper"

describe Zipper do
  it "zips hash with arrays into array of hashs" do
    before_zip = {
      "name"        => ["one", "two"],
      "belt_id"     => ["1", "2"],
      "category_id" => ["1", "2"],
      "description" => ["one", "two"]
    }

    after_zip = [
      {
        "name"        => "one",
        "belt_id"     => "1",
        "category_id" => "1",
        "description" => "one"
      },
      {
        "name"        => "two",
        "belt_id"     => "2",
        "category_id" => "2",
        "description" => "two"
      }
    ]

    expect(Zipper.new(before_zip).zip).to eq after_zip
  end
end
