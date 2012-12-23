if Rails.env.test? || Rails.env.development?
  WICKED_PDF = {
    :wkhtmltopdf => Rails.root.join('bin', 'wkhtmltopdf-i386').to_s,
    :exe_path => Rails.root.join('bin', 'wkhtmltopdf-i386').to_s
  }
end