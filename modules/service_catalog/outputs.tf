output "portfolio_id" {
  description = "ID of the Service Catalog portfolio"
  value       = aws_servicecatalog_portfolio.this.id
}

output "product_id" {
  description = "ID of the Service Catalog product"
  value       = aws_servicecatalog_product.this.id
}

output "portfolio_name" {
  value = aws_servicecatalog_portfolio.this.name
}

output "product_name" {
  value = aws_servicecatalog_product.this.name
}