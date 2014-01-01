class PagesController < ApplicationController
  def pdfexport
    wkhtml = Rails.root.join('vendor', 'pdfexport', "wkhtmltopdf-amd64")
    html = Rails.root.join('tmp', Dir::Tmpname.make_tmpname(['temp', '.html'], nil))
    pdf = Rails.root.join('tmp', Dir::Tmpname.make_tmpname(['temp', '.pdf'], nil))

    @assets_root = Rails.root.join('vendor', 'pdfexport', 'assets')

    @glykemieNalacno = params[:glykemieNalacno]
    @hba1c = params[:hba1c]
    @cholesterolCelkem = params[:cholesterolCelkem]
    @cholesterolHdl = params[:cholesterolHdl]
    @cholesterolLdl = params[:cholesterolLdl]
    @triacyglyceroly = params[:triacyglyceroly]
    @bmiFrom = params[:bmiFrom]
    @bmiTo = params[:bmiTo]
    @bmi = params[:bmi]
    @tlakDiastolicky = params[:tlakDiastolicky]
    @tlakSystolicky = params[:tlakSystolicky]

    File.open(html, 'w') do |f|
      str = render_to_string("pdfexport", :formats => [:html], :layout => false)
      f.write(str)
    end

    puts system(wkhtml.to_s, html.to_s, pdf.to_s)
    send_file(pdf.to_s, :filename => "cilove-hodnoty.pdf", :type => "application/pdf")
  end
end
