def klass
  described_class
end

def result
  { code: 1000 }
end

# def args
#   {
#     url: '/get_info',
#     method: :get,
#   }
# end

def new_class_attrs
  {
    username: Faker::Lorem.word,
    password: Faker::Lorem.word
  }
end

RSpec.shared_examples "Request sender" do |options|
  it 'sends request' do
    args = {
      url: options[:url],
      method: options[:method],
      headers: options[:headers],
    }

    expect_any_instance_of(described_class).to receive(:request).with(args).and_return(result)

    conn = described_class.new(**new_class_attrs)
    conn.send(:request, {url: args[:url], method: args[:method], headers: args[:headers]})
  end
end
