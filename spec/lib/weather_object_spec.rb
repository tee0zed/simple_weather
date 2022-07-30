# frozen_string_literal: true

RSpec.describe SimpleWeather::WeatherObject do
  let(:subject) { described_class.new(body: parsed_cassette_body(cassette_name), parse_route:) }

  describe '#temperature' do
    let(:method_call) { subject.temperature }

    context 'with :metric units' do
      context 'with weather_api provider' do
        context 'with current_weather' do
          let(:cassette_name) { 'weather_api_current_weather_metric' }
          let(:parse_route) { [:weather_api, :current_weather, :metric] }
          let(:expected_result) { 13.0 }

          it 'returns the temperature in celsius' do
            expect(method_call).to eq expected_result
          end
        end

        context 'with history_weather' do
          let(:cassette_name) { 'weather_api_history_weather_metric' }
          let(:parse_route) { [:weather_api, :history_weather, :metric] }
          let(:expected_result) { 15.0 }

          it 'returns the temperature in celsius' do
            expect(method_call).to eq expected_result
          end
        end
      end

      context 'with open_weather provider' do
        let(:cassette_name) { 'open_weather_current_weather_metric' }
        let(:parse_route) { %w[open_weather current_weather metric] }
        let(:expected_result) { 24.44 }

        context 'with current_weather' do
          it 'returns the temperature in celsius' do
            expect(method_call).to eq expected_result
          end
        end
      end
    end

    context 'with :imperial units' do
      context 'with weather_api provider' do
        context 'with current_weather' do
          let(:cassette_name) { 'weather_api_current_weather_imperial' }
          let(:parse_route) { %w[weather_api current_weather imperial] }
          let(:expected_result) { 55.4 }

          it 'returns the temperature in fahrenheit' do
            expect(method_call).to eq expected_result
          end
        end

        context 'with history_weather' do
          let(:cassette_name) { 'weather_api_history_weather_imperial' }
          let(:parse_route) { %w[weather_api history_weather imperial]  }
          let(:expected_result) { 59.0 }

          it 'returns the temperature in fahrenheit' do
            expect(method_call).to eq expected_result
          end
        end
      end

      context 'with open_weather provider' do
        let(:cassette_name) { 'open_weather_current_weather_imperial' }
        let(:parse_route) { %w[open_weather current_weather imperial]  }
        let(:expected_result) { 75.99 }

        context 'with current_weather' do
          it 'returns the temperature in fahrenheit' do
            expect(method_call).to eq expected_result
          end
        end

        context 'with unknown error' do
          let(:message) { 'unknown' }

          before do
            allow_any_instance_of(String).to receive(:to_sym).and_raise(StandardError, message)
          end

          it 'raises an error' do
            expect { method_call }.to raise_error(SimpleWeather::Errors::ParseError)
          end
        end
      end
    end
  end
end
