json.extract! document, :id, :file, :description, :created_at, :updated_at
json.url document_url(document, format: :json)
