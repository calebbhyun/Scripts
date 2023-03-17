# https://github.com/py-pdf/pypdf
# pip install pypdf

from pypdf import PdfReader, PdfWriter

reader = PdfReader("test.pdf")
writer = PdfWriter()
number_of_pages = len(reader.pages)

for i in range(number_of_pages):
    page = reader.pages[i]
    writer.add_page(page)

writer.add_js("app.alert('Test alert.');")

with open("test_js.pdf", "wb") as f:
    writer.write(f)
