package loja;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import loja.controller.AcessoController;
import loja.model.Acesso;
import loja.repository.AcessoRepository;
import loja.service.AcessoService;

@SpringBootTest(classes = LojaVirtualApplication.class)
class LojaVirtualApplicationTests {
	
	@Autowired 
	 private AcessoService acessoService;
	
	//@Autowired  
	//private AcessoRepository acessoRepository;  
	
	@Autowired
	AcessoController acessoController;
	

	@Test
	public void testeCadastroacesso () {
		
		Acesso acesso = new Acesso()  ;
		
		acesso.setDescricao("vendedor");

		acessoController.salvarAcesso(acesso);	
	}

}
