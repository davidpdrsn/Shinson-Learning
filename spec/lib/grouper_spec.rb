require_relative "../../lib/grouper"

describe Grouper do
  let(:bob) { double(:bob,
                     first_name: "Bob",
                     middle_name: "One",
                     last_name: "Johnson") }

  let(:another_bob) { double(:another_bob,
                             first_name: "Bob",
                             middle_name: "One",
                             last_name: "Markson") }

  let(:alice) { double(:alice,
                       first_name: "Alice",
                       middle_name: "Three",
                       last_name: "Cooper") }

  let(:things) { [bob, another_bob, alice] }

  it "groups a list of values by a method" do
    groups = Grouper.new(things).group_by(:first_name)

    expect(groups).to eq({"Bob" => [bob, another_bob], "Alice" => [alice]})
  end

  it "groups a list of values by several methods" do
    groups = Grouper.new(things).group_by(:first_name, :middle_name, :last_name)

    expect(groups["Bob"]["One"]["Johnson"]).to eq [bob]
    expect(groups["Bob"]["One"]["Markson"]).to eq [another_bob]
    expect(groups["Alice"]["Three"]["Cooper"]).to eq [alice]
  end
end
