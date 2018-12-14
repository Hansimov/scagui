import pdfkit

html_list = [  './html/doc_01_installation.html',
               './html/doc_02_gui.html',
               './html/doc_03_lib.html',
               './html/doc_04_support.html'];

pdfkit.from_file(html_list,'scatool_doc.pdf')

