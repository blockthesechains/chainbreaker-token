import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("ChainbreakerModule", (m) => {
  const initialSupply = m.getParameter("initialSupply", 1_000_000n * 10n ** 18n);

  const token = m.contract("Chainbreaker", [initialSupply]);

  return { token };
});