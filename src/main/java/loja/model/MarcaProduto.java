package loja.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;

@Entity
@Table(name="marca_produto")
@SequenceGenerator(name="seq_marca_produto",sequenceName="seq_marca_produto", allocationSize = 1, initialValue = 1 )
public class MarcaProduto implements Serializable {

	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_marca_produto"  ) 
	private long id;
	
	private String NomeDesc;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getNomeDesc() {
		return NomeDesc;
	}

	public void setNomeDesc(String nomeDesc) {
		NomeDesc = nomeDesc;
	}
	
	
	

}
