package loja.enums;

public enum StatusContaPagar {
	
	 COBRANCA("pagar"),
	 VENCIDA("vencida"),
	 ABERTA("aberta"),
	 QUITADA("quitada"),
	 ALUGUEL("aluguel"),
	 FUNCIONARIO("funcionario"),
	 RENEGOCIADA("renegociada"); 
	
	private String descricao;

	private StatusContaPagar(String descricao) {
		this.descricao = descricao;
	}
	
	
	public String getDescricao() {
		return descricao;
	}


	@Override
	public String toString() {
		
		return this.getDescricao();
	}

}
