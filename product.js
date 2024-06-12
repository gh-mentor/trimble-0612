function Product(productID, productName, categoryID, price, createdDate, modifiedDate) {
    this.m_ProductID = productID;
    this.m_ProductName = productName;
    this.m_CategoryID = categoryID;
    this.m_Price = price;
    this.m_CreatedDate = createdDate;
    this.m_ModifiedDate = modifiedDate;
}

Product.prototype.getProductName = function() {
    return this.m_ProductName;
}

Product.prototype.setProductName = function(productName) {
    this.m_ProductName = productName;
}

Product.prototype.getPrice = function() {
    return this.m_Price;
}

Product.prototype.setPrice = function(price) {
    if (price < 0) {
        throw new Error('Price cannot be negative');
    }
    this.m_Price = price;
}