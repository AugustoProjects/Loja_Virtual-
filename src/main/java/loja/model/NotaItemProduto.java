package loja.model;

import java.io.Serializable;


import java.util.Objects;


import jakarta.persistence.Column;
import jakarta.persistence.ConstraintMode;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;


@Entity
@Table(name = "nota_item_produto")
@SequenceGenerator(name="seq_nota_item_produto",sequenceName="seq_nota_item_produto", allocationSize = 1, initialValue = 1 )
public class NotaItemProduto implements Serializable  {
	
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy =GenerationType.SEQUENCE,generator ="seq_nota_item_produto"  )
	private long  id;
	@Column(nullable = false)
	private String quantidade;
	
	@ManyToOne
	@JoinColumn(name = "prosuto_id",nullable = false, foreignKey =@ForeignKey(value =ConstraintMode.CONSTRAINT,name = "produto_fk"  ))
	private Produto produto;
	
	@ManyToOne
	@JoinColumn(name = "nota_fiscal_compra_id",nullable = false, foreignKey =@ForeignKey(value =ConstraintMode.CONSTRAINT,name = "nota_fiscal_compra_fk"  ))
    private NotaFiscalCompra notaFiscalCompra;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getQuantidade() {
		return quantidade;
	}

	public void setQuantidade(String quantidade) {
		this.quantidade = quantidade;
	}

	public Produto getProduto() {
		return produto;
	}

	public void setProduto(Produto produto) {
		this.produto = produto;
	}

	public NotaFiscalCompra getNotaFiscalCompra() {
		return notaFiscalCompra;
	}

	public void setNotaFiscalCompra(NotaFiscalCompra notaFiscalCompra) {
		this.notaFiscalCompra = notaFiscalCompra;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		NotaItemProduto other = (NotaItemProduto) obj;
		return id == other.id;
	}
	
	

	
	
	
	
	
	

}
