# frozen_string_literal: true

RSpec.describe SimpleWeather::HTTP::Handler do
  let(:subject) { Class.new { include SimpleWeather::HTTP::Handler }.new }
  let(:method_call) { subject.handle(success_code:, &response) }
  let(:success_code) { 200 }

  let(:response) do
    -> { double(code: success_code, data: Random.new(9)) }
  end

  describe '#handler' do
    context 'with success response' do
      it 'returns response' do
        expect { method_call }.not_to raise_error
        expect(method_call.data).to eq response.call.data
      end
    end

    context 'with failed response' do
      let(:response) do
        -> { double(code: 401) }
      end

      it 'raises BadResponse' do
        expect { method_call }.to raise_error(SimpleWeather::BadResponse)
      end
    end
  end
end
