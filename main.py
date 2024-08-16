import pymupdf

def flip_pdf_y_axis(input_path, output_path):
    # Open the input PDF document
    doc = pymupdf.open(input_path)
    
    # Get the dimensions of the first page to compute the transformation matrix
    first_page = doc.load_page(0)
    width, height = first_page.rect.width, first_page.rect.height

    # Define the transformation matrix for flipping around the Y-axis
    # The matrix for flipping around the Y-axis is (-1, 0, 0, 1, width, 0)
    flip_matrix = pymupdf.Matrix(-1, 0, 0, 1, width, 0)

    flipped_doc = pymupdf.open()

    # Apply the transformation matrix to each page
    for page_num in range(len(doc)):
        print(page_num)
        page = doc.load_page(page_num)
        # page.transformation_matrix(flip_matrix)
        ptm = page.transformation_matrix
        # the inverse matrix of ptm is ~ptm
        # page.transformation_matrix = foobar
        pixmap = page.get_pixmap(matrix=flip_matrix)
        imgpdf = pymupdf.open("pdf", pixmap.pdfocr_tobytes(compress=False))
        flipped_doc.insert_pdf(imgpdf)

    # Save the modified document
    flipped_doc.save(output_path, deflate=True)
    flipped_doc.close()
    doc.close()

# Example usage
flip_pdf_y_axis("PDFS/Hypnosis_Handbook_of_Hypnotic_Inductions.pdf_text.pdf", "FLIPPED_PDFS/Hypnosis_Handbook_of_Hypnotic_Inductions.pdf")