package loja.enums;

public enum StatusContaReceber {
	
	 COBRANCA("pagar"),
	 VENCIDA("vencida"),
	 ABERTA("aberta"),
	 QUITADA("quitada"); 
	
	private String descricao;

	private StatusContaReceber(String descricao) {
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
