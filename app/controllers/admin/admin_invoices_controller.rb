class Admin::AdminInvoicesController < ApplicationController

def index
  @invoices = Invoice.all
end

def show
  @invoice = Invoice.find(params[:id])
  @invoice_items = @invoice.invoice_items
end

end
