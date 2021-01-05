---
dest: ./dist/votocol.pdf
stylesheet:
  - src/style.css
pdf_options:
  format: A4
  margin: 20mm
  printBackground: true
  headerTemplate: |-
    <style>
      section {
        width: 100%;
        font-family: system-ui;
        font-size: 11px;
        text-align: center;
        margin-left: 1cm;
        margin-right: 1cm;
      }
      section div {
        text-align: right;
      }
    </style>
    <section>
      Votocol - Protocolo de votação online - Versão 0.9.0
    </section>
  footerTemplate: |-
    <section>
      <div>
        <span class="pageNumber"></span>
      </div>
    </section>
---

<div class="middle-page"></div>

# Votocol – Protocolo de votação online
## Versão 0.9.0

<div class="page-break"></div>
