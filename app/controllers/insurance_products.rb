class InsuranceProducts < Application
  # provides :xml, :yaml, :js

  def index
    @insurance_products = InsuranceProduct.all
    display @insurance_products
  end

  def show(id)
    @insurance_product = InsuranceProduct.get(id)
    raise NotFound unless @insurance_product
    display @insurance_product
  end

  def new
    only_provides :html
    @insurance_product = InsuranceProduct.new
    display @insurance_product
  end

  def edit(id)
    only_provides :html
    @insurance_product = InsuranceProduct.get(id)
    raise NotFound unless @insurance_product
    display @insurance_product
  end

  def create(insurance_product)
    @insurance_product = InsuranceProduct.new(insurance_product)
    if @insurance_product.save
      redirect resource(@insurance_product), :message => {:notice => "InsuranceProduct was successfully created"}
    else
      message[:error] = "InsuranceProduct failed to be created"
      render :new
    end
  end

  def update(id, insurance_product)
    @insurance_product = InsuranceProduct.get(id)
    raise NotFound unless @insurance_product
    if @insurance_product.update(insurance_product)
       redirect resource(@insurance_product)
    else
      display @insurance_product, :edit
    end
  end

  def destroy(id)
    @insurance_product = InsuranceProduct.get(id)
    raise NotFound unless @insurance_product
    if @insurance_product.destroy
      redirect resource(:insurance_products)
    else
      raise InternalServerError
    end
  end

end # InsuranceProducts
