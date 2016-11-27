json.extract! system,
              :id,
              :standard_code,
              :internal_code,
              :particular_name,
              :x, :y,
              :created_at,
              :updated_at
json.url system_url(system, format: :json)
