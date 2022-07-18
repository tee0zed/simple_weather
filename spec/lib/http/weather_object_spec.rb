# frozen_string_literal: true

RSpec.describe SimpleWeather::HTTP::WeatherObject do
  let(:subject) { described_class.new(request:) }
  let(:request) { double(provider_name:, request_name:, units: 'metric', body:) }
  let(:request_name) { 'current_weather' }

  describe '#temperature' do
    let(:method_call) { subject.temperature }
    let(:body) do
      {
        'current' => {
          'temp_c' => '10'
        }
      }
    end

    context 'with weather_api provider' do
      let(:provider_name) { 'weather_api' }

      context 'with current_weather' do
        let(:expected_result) { '10' }

        it 'returns the temperature in metric' do
          expect(method_call).to eq expected_result
        end
      end

      context 'with history_weather' do
        let(:request_name) { 'history_weather' }

        let(:body) do
          {
            'forecast' => {
              'forecastday' => [
                'day' =>
                  { 'avgtemp_c' => '30' }
              ]
            }
          }
        end
        let(:expected_result) { '30' }

        it 'returns the temperature in metric' do
          expect(method_call).to eq expected_result
        end
      end

      context 'with unknown error' do
        let(:message) { 'unknown' }

        before do
          allow_any_instance_of(Hash).to receive(:dig).and_raise(StandardError, message)
        end

        it 'raises an error' do
          expect { method_call }.to raise_error(SimpleWeather::Exceptions::ParseError)
        end
      end
    end

    context 'with open_weather provider' do
      let(:provider_name) { 'open_weather' }
      let(:body) do
        {
          'main' => {
            'temp' => '40'
          }
        }
      end
      let(:expected_result) { '40' }

      context 'with current_weather' do
        it 'returns the temperature in metric' do
          expect(method_call).to eq expected_result
        end
      end
    end
  end
end
